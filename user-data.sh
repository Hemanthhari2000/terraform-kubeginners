sudo yum update -y
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user

docker pull hemanth0407/todo-app-kubeginners:v1
docker run -p 3000:80 -d hemanth0407/todo-app-kubeginners:v1