variable "clusters" {
  description = <<EOT
Map of clusters, attributes below
Required:
    - name
    - project_id
    - provider_instance_size_name
    - provider_name
Optional:
    - accept_data_risks_and_force_replica_set_reconfig
    - auto_scaling_compute_enabled
    - auto_scaling_compute_scale_down_enabled
    - auto_scaling_disk_gb_enabled
    - backing_provider_name
    - backup_enabled
    - cloud_backup
    - cluster_type
    - disk_size_gb
    - encryption_at_rest_provider
    - mongo_db_major_version
    - num_shards
    - paused
    - pit_enabled
    - provider_auto_scaling_compute_max_instance_size
    - provider_auto_scaling_compute_min_instance_size
    - provider_disk_iops
    - provider_disk_type_name
    - provider_encrypt_ebs_volume
    - provider_region_name
    - provider_volume_type
    - redact_client_log_data
    - replication_factor
    - retain_backups_enabled
    - termination_protection_enabled
    - version_release_system
    - advanced_configuration (block):
        - change_stream_options_pre_and_post_images_expire_after_seconds (optional)
        - custom_openssl_cipher_config_tls12 (optional)
        - default_max_time_ms (optional)
        - default_read_concern (optional)
        - default_write_concern (optional)
        - fail_index_key_too_long (optional)
        - javascript_enabled (optional)
        - minimum_enabled_tls_protocol (optional)
        - no_table_scan (optional)
        - oplog_min_retention_hours (optional)
        - oplog_size_mb (optional)
        - sample_refresh_interval_bi_connector (optional)
        - sample_size_bi_connector (optional)
        - tls_cipher_config_mode (optional)
        - transaction_lifetime_limit_seconds (optional)
    - bi_connector_config (block):
        - enabled (optional)
        - read_preference (optional)
    - labels (block):
        - key (optional)
        - value (optional)
    - pinned_fcv (block):
        - expiration_date (required)
    - replication_specs (block):
        - id (optional)
        - num_shards (required)
        - regions_config (optional, block):
            - analytics_nodes (optional)
            - electable_nodes (optional)
            - priority (optional)
            - read_only_nodes (optional)
            - region_name (required)
        - zone_name (optional)
    - tags (block):
        - key (required)
        - value (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    name                                             = string
    project_id                                       = string
    provider_instance_size_name                      = string
    provider_name                                    = string
    accept_data_risks_and_force_replica_set_reconfig = optional(string)
    auto_scaling_compute_enabled                     = optional(bool)
    auto_scaling_compute_scale_down_enabled          = optional(bool)
    auto_scaling_disk_gb_enabled                     = optional(bool)
    backing_provider_name                            = optional(string)
    backup_enabled                                   = optional(bool)
    cloud_backup                                     = optional(bool)
    cluster_type                                     = optional(string)
    disk_size_gb                                     = optional(number)
    encryption_at_rest_provider                      = optional(string)
    mongo_db_major_version                           = optional(string)
    num_shards                                       = optional(number)
    paused                                           = optional(bool)
    pit_enabled                                      = optional(bool)
    provider_auto_scaling_compute_max_instance_size  = optional(string)
    provider_auto_scaling_compute_min_instance_size  = optional(string)
    provider_disk_iops                               = optional(number)
    provider_disk_type_name                          = optional(string)
    provider_encrypt_ebs_volume                      = optional(bool)
    provider_region_name                             = optional(string)
    provider_volume_type                             = optional(string)
    redact_client_log_data                           = optional(bool)
    replication_factor                               = optional(number)
    retain_backups_enabled                           = optional(bool)
    termination_protection_enabled                   = optional(bool)
    version_release_system                           = optional(string)
    advanced_configuration = optional(object({
      change_stream_options_pre_and_post_images_expire_after_seconds = optional(number)
      custom_openssl_cipher_config_tls12                             = optional(set(string))
      default_max_time_ms                                            = optional(number)
      default_read_concern                                           = optional(string)
      default_write_concern                                          = optional(string)
      fail_index_key_too_long                                        = optional(bool)
      javascript_enabled                                             = optional(bool)
      minimum_enabled_tls_protocol                                   = optional(string)
      no_table_scan                                                  = optional(bool)
      oplog_min_retention_hours                                      = optional(number)
      oplog_size_mb                                                  = optional(number)
      sample_refresh_interval_bi_connector                           = optional(number)
      sample_size_bi_connector                                       = optional(number)
      tls_cipher_config_mode                                         = optional(string)
      transaction_lifetime_limit_seconds                             = optional(number)
    }))
    bi_connector_config = optional(object({
      enabled         = optional(bool)
      read_preference = optional(string)
    }))
    labels = optional(list(object({
      key   = optional(string)
      value = optional(string)
    })))
    pinned_fcv = optional(object({
      expiration_date = string
    }))
    replication_specs = optional(list(object({
      id         = optional(string)
      num_shards = number
      regions_config = optional(list(object({
        analytics_nodes = optional(number)
        electable_nodes = optional(number)
        priority        = optional(number)
        read_only_nodes = optional(number)
        region_name     = string
      })))
      zone_name = optional(string)
    })))
    tags = optional(list(object({
      key   = string
      value = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.clusters : (
        v.version_release_system == null || (contains(["LTS", "CONTINUOUS"], v.version_release_system))
      )
    ])
    error_message = "must be one of: \"LTS\", \"CONTINUOUS\""
  }
  # Note: 3 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

