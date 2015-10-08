BASEDIR=$(dirname $0)
echo "Changes since $2";
echo "<ul>";
git log $2..$3 --pretty=format:"<li>%s (<a href='http://drupalcode.org/project/$1.git/commit/%H'>view commit</a>)</li> " --reverse | grep -v Merge | sed -e 's/\.*\(#[a-zA-Z0-9]*\).*\((<a\.*\)/\[\1]\ \2/' | sed -e 's/<li>Issue /<li>/'
echo "</ul>";
