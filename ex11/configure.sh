apt install acl

folder="projet/collaboration"
file="$folder/shared_file.txt"

setfacl -m user:alice:rw "$file"
setfacl -m user:bob:r "$file"


setfacl -Rdm g:developers:rwx $folder
setfacl -Rdm g:guests:r $folder

