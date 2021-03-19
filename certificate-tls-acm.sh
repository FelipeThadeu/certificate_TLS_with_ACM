#!/bin/bash

#Updating the SO.
sudo apt update -y 
#sudo yum update -y

#Installing git.
sudo apt install git -y
#sudo yum install git -y

#Copping the OpenVPN repository.
git clone https://github.com/OpenVPN/easy-rsa.git
cd easy-rsa/easyrsa3

#Initialize a new PKI environment.
./easyrsa init-pki

#Build a new certificate authority (CA).
./easyrsa build-ca CA_name nopass

#Generate the server certificate and key.
./easyrsa build-server-full CA_name-server nopass

#Generate the client certificate and key.
#Make sure to save the client certificate and the client private key because you will need them when you configure the client.
./easyrsa build-client-full CA_name-client nopass

#Copy the server certificate and key and the client certificate and key to a custom folder and then navigate into the custom folder.
mkdir ../../certificates/
cp pki/ca.crt ../../certificates/
cp pki/issued/* ../../certificates/
cp pki/private/* ../../certificates/
rm -rf ../../easy-rsa
cd ../../certificates/

#Importing the certificate to ACM
#Server
aws acm import-certificate --certificate fileb://CA_name-server.crt --private-key fileb://CA_name-server.key --certificate-chain fileb://ca.crt --region us-east-1

#Client
aws acm import-certificate --certificate fileb://CA_name-client.crt --private-key fileb://CA_name-client.key --certificate-chain fileb://ca.crt --region us-east-1
