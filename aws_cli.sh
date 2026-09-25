curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

sudo apt install unzip

unzip awscliv2.zip
sudo ./aws/install

aws --version

echo "(OO)"
echo ("now Iam Role is :")
aws sts get-caller-identity
