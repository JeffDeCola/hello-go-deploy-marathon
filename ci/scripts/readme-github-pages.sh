#!/bin/sh
# hello-go-deploy-marathon readme-github-pages.sh

echo " "

if [ "$1" = "-debug" ]
then
    echo "readme-github-pages.sh -debug (START)"
    # set -e causes the shell to exit if any subcommand or pipeline returns a non-zero status. Needed for concourse.
    # set -x enables a mode of the shell where all executed commands are printed to the terminal.
    set -e -x
    echo " "
else
    echo "readme-github-pages.sh (START)"
    # set -e causes the shell to exit if any subcommand or pipeline returns a non-zero status.  Needed for concourse.
    set -e
    echo " "
fi

echo "The goal is to git clone /hello-go-deploy-marathon to /hello-go-deploy-marathon-updated"
echo "Then script will edit the /docs/_includes/README.md for GITHUB WEBPAGES"
echo "Finally push the changes in /docs/_includes/README.md to github"
echo " "

echo "At start, you should be in a /tmp/build/xxxxx directory with two folders:"
echo "   /hello-go-deploy-marathon"
echo "   /hello-go-deploy-marathon-updated (created in task-build-push.yml task file)"
echo " "

echo "pwd is: $PWD"
echo " "

echo "List whats in the current directory"
ls -la
echo " "

echo "git clone hello-go-deploy-marathon to hello-go-deploy-marathon-updated"
git clone hello-go-deploy-marathon hello-go-deploy-marathon-updated
echo " "

echo "cd hello-go-deploy-marathon-updated"
cd hello-go-deploy-marathon-updated
echo " "

echo "List whats in the current directory"
ls -la
echo " "

echo "FOR GITHUB WEBPAGES"
echo "THE GOAL IS TO COPY README.md to /docs/_includes/README.md"

echo "    Create and Edit temp-README.md"
echo "    Remove everything before the second heading in README.md.  Place in temp-README.md"
sed '0,/GitHub Webpage/d' README.md > temp-README.md
echo "    Change the first heading ## to #"
sed -i '0,/##/{s/##/#/}' temp-README.md
echo "    Update the image links (remove docs/)"
sed -i 's#IMAGE](docs/#IMAGE](#g' temp-README.md
# Deal with the SVGS images
# Add "https://raw.githubusercontent.com/JeffDeCola/REPONAME/master/svgs/" to "svgs/" 
# I would rather do a relative link but remember, github pages only "sees" the /docs directory
# So it's impossible to get into the svgs diretory. Hence we add the full link
echo "    Update the image links for svgs (if you have them)"
sed -i 's/svgs\//https:\/\/raw.githubusercontent.com\/JeffDeCola\/my-latex-graphs\/master\/svgs\//g' temp-README.md
echo " "

commit="yes"

echo "Does docs/_includes/README.md exist?"
if test -f docs/_includes/README.md
then
    echo "    Yes, it exists."
    # CHECK IF THERE IS A DIFF
    if (cmp -s temp-README.md docs/_includes/README.md)
    then
        commit="no"
        echo "    No changes are needed, Do not need to git commit and push"
    else
        echo "    Updates are needed"
    fi
    echo " "
else
    echo "    No, it does not exist"
    echo "    Creating the _includes directory"
    mkdir docs/_includes
    echo " "
fi

if [ "$commit" = "yes" ]
then
    echo "cp updated temp-README.md to docs/_includes/README.md"
    cp temp-README.md docs/_includes/README.md
    echo " "

    echo "Update some global git variables"
    git config --global user.email "jeffdecola@gmail.com"
    git config --global user.name "Jeff DeCola (Concourse)"
    echo " "
    git config --list
    echo " "

    echo "git add and commit what is needed to protect from unforseen issues"
    echo "git add docs/_includes/README.md"
    git add docs/_includes/README.md
    echo " "

    echo " git commit -m \"Update docs/_includes/README.md for GitHub WebPage\""
    git commit -m "Update docs/_includes/README.md for GitHub WebPage"
    echo " "

    echo "git status"
    git status
    echo " "
    
    echo "git push  - Not needed here since its done in pipeline"
    echo " "
fi

echo "rm temp-README.md"
rm temp-README.md
echo " "

echo "readme-github-pages.sh (END)"
echo " "
