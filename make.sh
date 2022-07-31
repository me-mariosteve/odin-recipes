#! /bin/bash

set -ue
function die () {
	echo "$1" >&2
	exit "${2:-1}"
}


dest="${dest:-/srv/http}"
declare -a tocopy=(
	$(find . -maxdepth 1 -type f \
		-a -iname '*.html' -o -iname '*.css'\
		-o -iname '*.png' -o -iname '*.ico' \
	)
	recipes
)
tocopy_str="${tocopy[*]}"

echo "dest='$dest'"
echo "tocopy=($tocopy_str)"


function sidebar-recipes-list () {
	cat sidebar-template.html
	echo '		<ul class="recipes-list">'
	for recipe in recipes/[a-z]*.html; do
		recipe_name="$(sed -E 's/^recipes\/(.*?)\.html$/\u\1/;'<<<"$recipe")"
		echo "			<li><a href=\"$recipe\" alt=\"Recipe for '$recipe_name'\">$recipe_name</a></li>"
	done
	cat <<EOF
		</ul>
	</body>
</html>
EOF
}

function clean () {
	rm -rf $(bash -c "echo $dest/{${tocopy_str// /,}}") sidebar.html
}


if [ $# -eq 1 ] && [ "$1" = clean ]; then
	clean
else
	clean
	sidebar-recipes-list > sidebar.html
	cp -r "${tocopy[@]}" "$dest"
fi
