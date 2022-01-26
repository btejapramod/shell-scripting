LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

STAT() {
  if [ $1 -eq 0 ]; then
  echo -e "\e[1;32mSUCCESS\e[0m"
  else
    echo -e "\e[1;31mFAILED\e[0m"
    exit 2
    fi
    }
NODEJS(){
COMPONENT=$1
echo "Setup NodeJS Repo"
curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash - &>>LOG_FILE
STAT $?

echo "Install NodeJS"
yum install nodejs gcc-c++ -y &>>LOG_FILE
STAT $?

echo "Create APP User"
id roboshop &>>LOG_FILE
if [ $? -ne 0 ]; then
useradd roboshop &>>LOG_FILE
fi
STAT $?

echo "Downloading the ${COMPONENT} code"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>LOG_FILE
STAT $?

echo "Extract the ${COMPONENT} code"
cd /tmp/
unzip -o ${COMPONENT}.zip &>>LOG_FILE
STAT $?

echo "Clean old content"
rm -rf /home/roboshop/${COMPONENT}
STAT $?

echo "Copy ${COMPONENT} content"
cp -r ${COMPONENT}-main /home/roboshop/${COMPONENT} &>>LOG_FILE
STAT $?

echo "Install the dependencies"
cd /home/roboshop/${COMPONENT}
npm install &>>LOG_FILE
STAT $?

chown roboshop:roboshop /home/roboshop/ -R &>>LOG_FILE

echo "Update ${COMPONENT} SystemD file"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal/'  /home/roboshop/${COMPONENT}/systemd.service &>>$LOG_FILE
STAT $?

echo "Setup ${COMPONENT} SystemD file"
mv /home/roboshop/${COMPONENT}/systemd.service  /etc/systemd/system/${COMPONENT}.service &>>$LOG_FILE
STAT $?

echo "Start ${COMPONENT}"
systemctl daemon-relaod  &>>$LOG_FILE
systemctl enable ${COMPONENT} &>>$LOG_FILE
systemctl restart ${COMPONENT} &>>$LOG_FILE
STAT $?
}