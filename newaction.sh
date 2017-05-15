if [[ -z "$*" ]]; then
	echo Specify new action name
	exit 1
fi

cp src/actions/example.sh src/actions/"$1".sh

sed "s/_example/_$1/" -i src/actions/"$1".sh
