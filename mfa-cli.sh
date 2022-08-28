#!/bin/zsh 
set -eu
# . ./mfa-cli.sh to run on current working shell
# specify your MFA_DEVICE_ARN

vared -p 'Please enter MFA ARN: ' -c MFA_DEVICE_ARN
echo "You entered '$MFA_CODE'"
vared -p 'Please enter MFA code: ' -c MFA_CODE
echo "You entered '$MFA_CODE'"

if [ -z ${MFA_DEVICE_ARN}]; then
    echo "Please specify the MFA_DEVICE_ARN"
    exit 1
fi
if [ -z ${MFA_CODE}]; then
    echo "Please specify the MFA_DEVICE_ARN"
    exit 1
fi

COMMAND=`/usr/local/bin/aws --output text sts get-session-token \
    --serial-number $MFA_DEVICE_ARN \
    --token-code $MFA_CODE`

echo $COMMAND
CREDS=$COMMAND

KEY=$(echo "${CREDS}" | cut -f2)
SECRET=$(echo $CREDS | cut -f4)
SESS_TOKEN=$(echo $CREDS | cut -f5)

echo "export AWS_ACCESS_KEY_ID=$KEY"
echo "export AWS_SECRET_ACCESS_KEY=$SECRET"
echo "export AWS_SESSION_TOKEN=$SESS_TOKEN"

export AWS_ACCESS_KEY_ID=$KEY
export AWS_SECRET_ACCESS_KEY=$SECRET
export AWS_SESSION_TOKEN=$SESS_TOKEN

# check if script has been sourced or executed
(return 0 2>/dev/null) && sourced=1 || sourced=0
if [ $sourced -eq 1 ]; then
    echo "Script was sourced."
else
    echo "Script was executed, starting subshell."
    zsh -l
fi
