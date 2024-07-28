#!/bin/bash

# Prompt the user for their email
read -p "Enter your GitHub email: " email

# Generate the SSH key
ssh-keygen -t ed25519 -C "$email" -f ~/.ssh/id_ed25519 -N ""

# Start the SSH agent in the background
eval "$(ssh-agent -s)"

# Add the SSH private key to the SSH agent
ssh-add ~/.ssh/id_ed25519

# Display the SSH public key and copy it to the clipboard (requires xclip)
if command -v xclip &> /dev/null
then
    cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
    echo "Your SSH key has been copied to the clipboard."
else
    echo "xclip is not installed. Here is your SSH public key:"
    cat ~/.ssh/id_ed25519.pub
    echo "Please manually copy the above key."
fi

echo "Add the SSH key to your GitHub account:"
echo "1. Go to https://github.com"
echo "2. In the upper-right corner, click your profile photo, then click Settings."
echo "3. In the left sidebar, click SSH and GPG keys."
echo "4. Click New SSH key."
echo "5. Paste your key into the Key field."
echo "6. Add a descriptive title, and click Add SSH key."
