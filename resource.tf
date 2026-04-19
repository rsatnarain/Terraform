resource "aws_instance" "myec2" {
    ami = "ami-098e39bafa7e7303d"
    instance_type = "t3.micro"
    tags = {
        "Name" = "MyEC2Instance"
    }    
}