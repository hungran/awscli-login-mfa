# awscli-login-mfa
## Preq
- AWS AccessKey & SecretKey available in your ./aws/credentials
## using OSx:

```bash
. ./mfa-cli.sh
```

- Enter MFA_ARN like: `arn:aws:iam::<account_id>:mfa/xxxx`
- Enter MFA_CODE like: `123456`

- Then use `aws sts get-caller-identity` && `aws configure list` to make sure it works
