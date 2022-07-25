# packer-ec2-windows-jenkins-slave
packer ec2 windows jenkins slave

Create an AWS jenkins slave over windows for EC2 plugin
```packer init win2019-jenkins-node.pkr.hcl```

```packer build -var 'profile=<YOUR AWS PROFILE>' -var 'region=<YOUR AWS REGION>' win2019-jenkins-node.pkr.hcl```

## In AWS

you Security group must be open on port 445 5985/596 ![image](https://user-images.githubusercontent.com/6726241/180745941-ef85c901-6382-43ef-8087-e9c0b29898b7.png)

## In Jenkins 
![image](https://user-images.githubusercontent.com/6726241/180746531-6e634a24-1aef-4aeb-afcd-e780f780973c.png)

you must add the Subnet too

![image](https://user-images.githubusercontent.com/6726241/180746790-d217f6dd-70c7-44ab-a23f-d403f6ab8aa7.png)




