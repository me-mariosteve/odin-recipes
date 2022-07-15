#! /bin/bash

set -ue
function die () {
	echo "$1" >&2
	exit "${2:-1}"
}


dest="${dest:-/srv/http}"
declare -a tocopy=(
	index.html styles.css
	sidebar.html
	home-16x16.png github-16x16.png top-16x16.png
	recipes
)
tocopy_str="${tocopy[*]}"


function sidebar-recipes-list () {
	cat sidebar-template.html
	echo '		<ul class="recipes-list">'
	for recipe in recipes/[a-z]*.html; do
		recipe_name="$(sed -E 's/^recipes\/(.*?)\.html$/\u\1/;'<<<"$recipe")"
		echo "			<li><a href='$recipe' target='_top'>$recipe_name</a></li>"
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
