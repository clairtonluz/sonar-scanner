# sonar-scanner
Sonar scanner docker image

### How to use

1) Project setup
create your **sonar-project.properties** into project root folder. Below a example to **ReactJS**

```properties
# Configuration to react project created with create-react-app 
sonar.projectKey=br.com.clairtonluz:example
sonar.projectName=Example
sonar.projectVersion=1.0

sonar.sources=src
sonar.tests=src
sonar.test.inclusions=src/**/*.test.ts,src/**/*.test.tsx,src/**/*.spec.js,src/**/*.spec.jsx,src/**/*.test.js,src/**/*.test.jsx
# If your project use javascript instead of typescript change "sonar.typescript.lcov.repostPaths" to "sonar.javascript.lcov.repostPaths"
sonar.typescript.lcov.reportPaths=coverage/lcov.info

sonar.sourceEncoding=UTF-8
sonar.exclusions=**/node_modules/**, build/**

```

2) Now run this command to enter into docker container with your code
```shell
docker run -e SONAR_HOST_URL=<YOUR_SONAR_HOST_URL> \
    -e SONAR_TOKEN=<YOUR_SONAR_TOKEN> \
    --entrypoint=/bin/bash \
    -it -v "/path/to/your/project:/usr/src" \
    clairtonluz/sonar-scanner-cli
```


2) Run coverage e send to sonar
```shell
docker run -e SONAR_HOST_URL=<YOUR_SONAR_HOST_URL> \
    -e SONAR_TOKEN=<YOUR_SONAR_TOKEN> \
    --entrypoint=/bin/bash \
    -it -v "/path/to/your/project:/usr/src" \
    clairtonluz/sonar-scanner-cli

# Into image docker run this to generate coverage
npx react-scripts test --coverage --coverageReporters=lcov --env=jsdom --watchAll=false

# send coverage to sonar
sonar-scanner
```

3) Setup Gitlab job in .gitlab-ci.yml to automatically send coverage to sonar
```yml
test:
  image: sonarsource/sonar-scanner-cli
  variables:
    SONAR_HOST_URL: <your_sonar_url_here>
    SONAR_TOKEN: <your_token_here>
  script:
   - npm install
   - npx react-scripts test --coverage --coverageReporters=lcov --env=jsdom --watchAll=false
   - sonar-scanner -Dsonar.projectKey="$CI_PROJECT_NAMESPACE/$CI_PROJECT_NAME" -Dsonar.projectName="$CI_PROJECT_TITLE"
```