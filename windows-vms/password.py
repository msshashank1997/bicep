import secrets
import string
import random
import subprocess

def generate_password(n):
    # Define the set of allowed characters
    allowed_chars = string.ascii_letters + string.digits + "!#$%^&*-"

    # Define the set of disallowed special characters
    disallowed_special_chars = "@()_=+[]|;:,.<>?~'"

    # Remove disallowed special characters from the allowed character set
    allowed_chars = ''.join(char for char in allowed_chars if char not in disallowed_special_chars)

    # Generate the password using the allowed character set
    password = ''.join(random.choice(allowed_chars) for _ in range(n))

    return password

# Generate a password of length 12
n = 12
pwd = generate_password(n)
print(pwd)


def replace_value_in_file(file_path, old_value, new_value):
    with open(file_path, 'r') as file:
        # Read the contents of the file
        file_contents = file.read()

        # Replace the old value with the new value
        modified_contents = file_contents.replace(old_value, new_value)

    with open(file_path, 'w') as file:
        # Write the modified contents back to the file
        file.write(modified_contents)

replace1= "GEN-PASSWORD"
replace2 = 'DID'
d = 6
DepID = random.randint(int('1'+'0'*(d-1)), int('9'*d))
DepID = str(DepID)
print(DepID) 
  
# Replacing the Value of UPA and Password in bpa
replace_value_in_file('parameters.json' ,replace1 ,pwd)
replace_value_in_file('parameters.json' ,replace2 ,DepID)
replace_value_in_file('deploybicep.ps1' ,replace2 ,DepID)
    
#Deploying the resources thought powershell
powershell_script = "deploybicep.ps1"
    
result = subprocess.run(["powershell", "-File", powershell_script], capture_output=True, text=True)

# Check the result
if result.returncode == 0:
    # Script executed successfully
    output = result.stdout
    print("Script output:")
    print(output)
else:
    # Script failed
    error = result.stderr
    print("Script failed with error:")
    print(error)


replace_value_in_file('parameters.json', pwd, replace1)
replace_value_in_file('parameters.json', DepID , replace2)
replace_value_in_file('deploybicep.ps1', DepID , replace2)    