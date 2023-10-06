auto_auth {
  method "approle" {
    mount_path = "auth/approle"
    config = {
      role_id_file_path                   = "roleid"
      secret_id_file_path                 = "secretid"
      remove_secret_id_file_after_reading = false
    }
  }
}

listener "tcp" {
  address     = "127.0.0.1:8007"
  tls_disable = true
}


vault {
  address = "http://127.0.0.1:8200"
}

env_template "HELLO_KEY" {
  contents             = "{{ with secret \"kv/data/hello\" }}{{ .Data.data.key }}{{ end }}"
  error_on_missing_key = true
}

exec {
  command                   = ["./demo-2.sh"]
  restart_on_secret_changes = "always"
  restart_stop_signal       = "SIGTERM"
}
