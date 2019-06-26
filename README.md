# sonar-scanner
Sonar scanner docker image

### How to use

1) Project setup
create your **sonar-project.properties** into project root folder. Below a example to **ReactJS**

```properties
# must be unique in a given SonarQube instance
sonar.projectKey=aluno-online-react
# this is the name and version displayed in the SonarQube UI. Was mandatory prior to SonarQube 6.1.
sonar.projectName=Aluno Online React
sonar.projectVersion=1.0
 
# Path is relative to the sonar-project.properties file. Replace "\" by "/" on Windows.
# This property is optional if sonar.modules is set. 
sonar.sources=.
 
# Encoding of the source code. Default is default system encoding
sonar.sourceEncoding=UTF-8
# sonar.javascript.file.suffixes=.js,.jsx
sonar.host.url=http://sonar.seduc.ce.gov.br:9002
sonar.login=65a7a2228ac6c0adde3788560d4ae22503cce04f
sonar.exclusions="**/node_modules/**"
```

2) Now into project root folder run this command
```shell
docker run -ti -v $(pwd):/src clairtonluz/sonar-scanner sonar-scanner
```