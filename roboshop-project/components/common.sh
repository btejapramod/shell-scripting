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
useradd roboshop &>>LOG_FILE
STAT $?

echo "Downloading the User code"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/roboshop-devops-project/$COMPONENT/archive/main.zip" &>>LOG_FILE
STAT $?

echo "Extract the $COMPONENT code"
unzip /tmp/$COMPONENT.zip &>>LOG_FILE
STAT $?

echo "Clean old content"
rm -rf /home/roboshop/$COMPONENT
STAT $?

echo "Copy $COMPONENT content"
cp -r $COMPONENT-main $COMPONENT &>>LOG_FILE
STAT $?

echo "Install the dependencies"
cd /home/roboshop/$COMPONENT
npm install &>>LOG_FILE
STAT $?

chown roboshop:roboshop /home/roboshop/ -R
echo "Update SystemD file"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/roboshop/$COMPONENT/systemd.service &>>$LOG_FILE
STAT $?

echo "Setup $COMPONENT SystemD file"
mv /home/roboshop/$COMPONENT/systemd.service  /etc/systemd/system/$COMPONENT.service &>>$LOG_FILE
STAT $?

echo "Start $COMPONENT"
systemctl daemon-relaod  &>>$LOG_FILE
systemctl enable $COMPONENT &>>$LOG_FILE
systemctl start $COMPONENT &>>$LOG_FILE
STAT $?
}