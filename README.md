# ElectricFlow 데모 프로젝트

- 도커 스웜을 이용한 멀티서버 환경에서의 ElectricFlow 배포
- AWS 에 Docke Swarm 노드 3개를 생성하여 ElectricFlow 를 배포
- 실행 전 AWS Access Key, AWS Secret Key 를 얻어내 저장 필요
- 실행 전  EF 인스톨러를 efswarm 폴더에 저장

## Swarm 노드 자동 설치 (AWS) 

```console
 $ sudo ./installSwarm.sh
 $ cd swarm
 $ terraform init
 $ terraform apply
 ```
 
 ## Master Node 로 로그인
 
 ```console
  $ ssh -i mykey ubuntu@$(terraform output master_public_ip)
  $ sudo docker node ls
 ```  
 
 ## Master Node 에서 Deploy
 
  ```console
  $ export EFLOW_INSTALLER=/tmp/ElectricFlow-x64-9.0.1.136311
  $ git clone https://github.com/kin3303/efdocker
  $ cd efdocker
  $ sudo docker stack deploy -c docker-stack.yml EF
  $ sudo docker stack ps EF
  $ sudo docker stack rm EF
 ```
 
