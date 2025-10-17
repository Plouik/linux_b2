user_list=("alice" "bob")
group_list=("developers" "guests")

for username in "${user_list[@]}"; do
    if id "$username" &>/dev/null; then
        echo "user: $username exists"
    else
        echo "Création du user $username"
        useradd "$username"
    fi
done

for group in "${group_list[@]}"; do
    if getent group "$group" &>/dev/null; then
        echo "group: $group exists"
    else
        echo "Création du group $group"
        groupadd "$group"
    fi
done

usermod -a -G guests bob
usermod -a -G developers alice

folder="projet/collaboration"
file="$folder/shared_file.txt"
mkdir -p "$folder"
echo "test" > $file
echo "group" > "$folder/group_test.txt"
