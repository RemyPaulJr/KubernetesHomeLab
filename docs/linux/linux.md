## Create new user and give sudo persmissions

Add new user:
```bash
sudo adduser new_username
```

- Set password
- Can add user information (optional), enter to skip

Add user to the sudo group:
```bash
sudo usermod -aG sudo new_username
```
