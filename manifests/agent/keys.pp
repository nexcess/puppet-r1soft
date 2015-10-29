class r1soft::agent::keys {
  if ! empty($r1soft::agent::keys) {
    create_resources(r1soft::agent::key, $r1soft::agent::keys)
  }
}
