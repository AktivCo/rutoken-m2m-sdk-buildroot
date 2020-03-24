#!/bin/sh

Bold='\e[1m'
Red='\e[31m'
Green='\e[32m'
Yellow='\e[93m'
Purple='\e[35m'

End='\e[0m'

print_error(){
	echo " "
	echo "${Red}Error${End}: ${Bold}${1}${End}"
}

print_succeed(){
	echo " "
	echo "${Green}Success${End}: ${Bold}${1}${End}"
}

print_info(){
	echo " "
	echo "${Yellow}Info${End}: ${Bold}${1}${End}"
}

check_model(){

	if ! echo $1 | grep -Eq '^(rpi2|rpi3)'; then
		print_error "Incorrect model type"
		exit 1
	fi
}

usage(){

	echo "Usage: build.sh [options] -b {rpi2|rpi3}"
	echo "Options:"
	echo "       -p               pack sources of buildroot with licence files
                                  for distribution and write them to target filesystem"
	echo "       -b  {rpi2|rpi3}  choose target raspberry pi model"
	echo "       -h               see this message"
}

exit_if_error_occured(){

	if [ $1 -ne 0 ]; then
		print_error "something went wrong"
		exit 1
	else
		true
	fi
	return
}

make_defconfig(){

	defconfig="rutoken_m2m_${1}_defconfig"

	print_info "setting configuration"
	make $defconfig
	exit_if_error_occured $?
}

build(){

	board=$1
	make_defconfig $board
	make all
	exit_if_error_occured $?
}

build_production(){

	board=$1
	sources_dir="output/sources"
	mkdir -p  $sources_dir

	print_info "sources downloading"
	make_defconfig $board
	make source
	exit_if_error_occured $?


	print_info "collecting licenses"
	make legal-info
	exit_if_error_occured $?

	mkdir legal-info
	origin_legal_info="output/legal-info"
	cp -r "${origin_legal_info}/host-licenses" ./legal-info/
	cp -r "${origin_legal_info}/licenses" ./legal-info/
	cp -r "${origin_legal_info}/manifest.csv" ./legal-info/
	cp -r "${origin_legal_info}/host-manifest.csv" ./legal-info/

	revision=$(git rev-parse HEAD)
	echo revision > version

	print_info "packing sources"
	mkdir -p output/sources/
	zip -r --symlinks output/sources/sources.zip . \
		-x 'output/*' -x '.git*'
	exit_if_error_occured $?

	rm -rf legal-info

	buildroot_sources_path="output/legal-info/buildroot-sources/buildroot-${revision}"
	mkdir -p $buildroot_sources_path
	rsync -a --exclude 'output' --exclude '.git*' --exclude 'dl' ./  "${buildroot_sources_path}/"
	exit_if_error_occured $?


	print_info "building linux"
	make all
	exit_if_error_occured $?
}

main(){

	if [ $# -lt 1 ]; then
		usage
		exit 1
	fi

	model=""
	production=false

	while getopts ":hpb:" opt; do
		case $opt in
			h)
				usage
				exit 0
			;;
			p)
				production=true
			;;
			b)
				model=$OPTARG
				check_model $model
			;;
			*)
				print_error "unknown argument"
				usage
				exit 1
			;;
		esac
	done

	if [ -z $model ]; then
		print_error "no board specified"
		exit 1
	fi

	if $production; then
		build_production $model
		print_succeed "Production build done!"
	else
		build $model
		print_succeed "Build done!"
	fi

	exit 0
}


main $*
