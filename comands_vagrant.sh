sudo apt-get install curl apt-transport-https lsb-release gnupg -y
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-get install azure-cli
az login

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io


curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install nodejs -y
node --version
npm --version
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install azure-functions-core-tools-3

sudo apt-get update; \
 sudo apt-get install -y apt-transport-https && \
 sudo apt-get update && \
 sudo apt-get install -y dotnet-sdk-3.1

mkdir testAzureFunctions
cd testAzureFunctions

func init AzureFuncTestProj --docker
#opcion 1
cd AzureFuncTestProj/
func new
#opcion 2: HttpTrigger
#Funtion name: search
func start --build
# probar: curl http://192.168.100.3:7071/api/Search
vim search.cs

"La función de activación HTTP de C # procesó una solicitud"
# obtener todas las personas http://192.168.100.3:7071/api/Search?name
# obtener una persona http://192.168.100.3:7071/api/Search?name=lucas
############### configurar anonymus en search.cs ##############
sudo docker build -t myprojectname .
sudo docker images
sudo docker run -p 8080:80 myprojectname
# obtener todas las personas http://192.168.100.3:8080/api/Search?name
# obtener una persona http://192.168.100.3:8080/api/Search?name=lucas
sudo docker login
#cambiar nombre groloboy/myprojectname
sudo docker tag myprojectname groloboy/myprojectname
sudo docker push groloboy/myprojectname

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az group create --name AzureFunctionsContainers-rg --location centralus
# cambiar nombre bquinonesufuncstorage
az storage account create --name bquinonesufuncstorage --location westeurope --resource-group AzureFunctionsContainers-rg --sku Standard_LRS
az functionapp plan create --resource-group AzureFunctionsContainers-rg --name myPremiumPlan --location centralus --number-of-workers 1 --sku EP1 --is-linux

# cambiar nombre bquinonesFuncAzure
az functionapp create --name bquinonesFuncAzure --storage-account bquinonesufuncstorage --resource-group AzureFunctionsContainers-rg --plan myPremiumPlan --runtime dotnet --deployment-container-image-name groloboy/myprojectname
az storage account show-connection-string --resource-group AzureFunctionsContainers-rg --name bquinonesufuncstorage --query connectionString --output tsv
az functionapp config appsettings set --name bquinonesFuncAzure --resource-group AzureFunctionsContainers-rg --settings AzureWebJobsStorage=DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=bquinonesufuncstorage;AccountKey=Q+9Jwz8rpmoL2JG0z+g5i3fAa+il6g6bkVnMluToRFxI97z7kX/puTFqBBGya8E/mFktkt1PShsKDyGf7XdfbQ==


# obtener todas las personas https://bquinonesfuncazure.azurewebsites.net/api/Search?name
# obtener una persona https://bquinonesfuncazure.azurewebsites.net/api/Search?name=lucas









git clone https://github.com/awssimplified/RESTApiNodeJS.git


sudo docker build -t nodeapirest .
sudo docker images
sudo docker run -it -p 3000:3000 --name=nodeapi nodeapirest
# curl -d 'user=admin&name=admin&email=admin@gmail.com' -X POST http://192.168.100.3:3000/users
# curl -d 'user=admin&name=admin2' -X PUT http://192.168.100.3:3000/users?user=admin
# curl -X DELETE http://192.168.100.3:3000/users?user=user1

#cambiar nombre groloboy/nodeapirest
sudo docker tag nodeapirest groloboy/nodeapirest
sudo docker push groloboy/nodeapirest

# cambiar nombre bquinonesreststorage
az storage account create --name bquinonesreststorage --location westeurope --resource-group AzureFunctionsContainers-rg --sku Standard_LRS
az functionapp plan create --resource-group AzureFunctionsContainers-rg --name myPremiumPlan --location centralus --number-of-workers 1 --sku EP1 --is-linux

# cambiar nombre bquinonesRestAzure
az functionapp create --name bquinonesRestAzure --storage-account bquinonesreststorage --resource-group AzureFunctionsContainers-rg --plan myPremiumPlan --runtime dotnet --deployment-container-image-name groloboy/nodeapirest
az storage account show-connection-string --resource-group AzureFunctionsContainers-rg --name bquinonesreststorage --query connectionString --output tsv
az functionapp config appsettings set --name bquinonesRestAzure --resource-group AzureFunctionsContainers-rg --settings AzureWebJobsStorage=DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=bquinonesreststorage;AccountKey=lJpnXqEZc1uXeJ+Z7bYVQ+evzNEezmcwm24xI6o+R7KF5q9E3mfvIoIsiO3vsLs7az9jdHCApy4qqT6bc++6xg==

# obtener todas las personas https://bquinonesRestAzure.azurewebsites.net/users
# obtener una persona https://bquinonesRestAzure.azurewebsites.net/users?name=lucas

# curl -d 'user=admin&name=admin&email=admin@gmail.com' -X POST https://bquinonesRestAzure.azurewebsites.net/users
# curl -d 'user=admin&name=admin2' -X PUT https://bquinonesRestAzure.azurewebsites.net/users?user=admin
# curl -X DELETE https://bquinonesRestAzure.azurewebsites.net/users?user=user1