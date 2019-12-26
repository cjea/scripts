# email_pw_post_requests reads a csv of email,password
# rows and prints cURL commands formatted with 
# bearer token, email, and password. Pass a token and url
# (defaults to Xs and httpbin). Skips the CSV header row.
#
# Just use as a template to get awk doing stuff.
#
# $ awk -f email_pw_post_requests.awk \
#     [ -v token="$(sso_token)" -v url="https://httpbin.org/post" ] \
#     email_pw.csv
# $ awk -f email_pw_post_requests.awk
BEGIN { 
  FS=",";
  if(token == "") { token = "XXXXXXXXX" }
  if(url == "") { url = "https://httpbin.org/post" }
}

NR != 1 { print_cmd($1, $2); print "\n" }

# print_cmd formats a multiline cURL command that
# posts to `url`, sending bearer token, email, password
function print_cmd(email, password) {
  print "curl -X POST " url " \\"
  print "\t" bearerToken(token) " \\"
  print "\t" formData("email", email) " \\"
  print "\t" formData("password", password)
}

function formData(key, val) {
  return cliFlag("d", key "=" val)
}

function bearerToken(token) {
  return cliFlag("H", "Authoriation: Bearer " token)  
}


function cliFlag(letter, value) {
  return "-" letter " '" value "'"
}

