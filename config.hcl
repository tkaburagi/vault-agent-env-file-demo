auto_auth {
  method "approle" {
    mount_path = "auth/approle"
    config = {
      role_id_file_path                   = "roleid"
      secret_id_file_path                 = "secretid"
      remove_secret_id_file_after_reading = false
    }
  }

listener "tcp" {
  address     = "127.0.0.1:8007"
  tls_disable = true
}


vault {
  address = "http://127.0.0.1:8200"
}

template_config {
  static_secret_render_interval = "5s"
}

template {
  source      = "kv.tmpl"
  destination = "render-kv.txt"
}
