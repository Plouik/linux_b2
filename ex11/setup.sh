apt install acl

useradd bob
useradd alice
groupadd developers
groupadd guests

folder="projet/collaboration"
file="$folder/shared_file.txt"

mkdir -p "$folder"
echo "test" > $file

usermod -a -G guests bob

echo "group" > "$folder/group_test.txt"

cat ex11/projet/collaboration/group_test.txt