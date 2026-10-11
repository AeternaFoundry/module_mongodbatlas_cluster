resource "mongodbatlas_cluster" "clusters" {
  for_each = var.clusters

  name                                             = each.value.name
  project_id                                       = each.value.project_id
  provider_instance_size_name                      = each.value.provider_instance_size_name
  provider_name                                    = each.value.provider_name
  accept_data_risks_and_force_replica_set_reconfig = each.value.accept_data_risks_and_force_replica_set_reconfig
  auto_scaling_compute_enabled                     = each.value.auto_scaling_compute_enabled
  auto_scaling_compute_scale_down_enabled          = each.value.auto_scaling_compute_scale_down_enabled
  auto_scaling_disk_gb_enabled                     = each.value.auto_scaling_disk_gb_enabled
  backing_provider_name                            = each.value.backing_provider_name
  backup_enabled                                   = each.value.backup_enabled
  cloud_backup                                     = each.value.cloud_backup
  cluster_type                                     = each.value.cluster_type
  disk_size_gb                                     = each.value.disk_size_gb
  encryption_at_rest_provider                      = each.value.encryption_at_rest_provider
  mongo_db_major_version                           = each.value.mongo_db_major_version
  num_shards                                       = each.value.num_shards
  paused                                           = each.value.paused
  pit_enabled                                      = each.value.pit_enabled
  provider_auto_scaling_compute_max_instance_size  = each.value.provider_auto_scaling_compute_max_instance_size
  provider_auto_scaling_compute_min_instance_size  = each.value.provider_auto_scaling_compute_min_instance_size
  provider_disk_iops                               = each.value.provider_disk_iops
  provider_disk_type_name                          = each.value.provider_disk_type_name
  provider_encrypt_ebs_volume                      = each.value.provider_encrypt_ebs_volume
  provider_region_name                             = each.value.provider_region_name
  provider_volume_type                             = each.value.provider_volume_type
  redact_client_log_data                           = each.value.redact_client_log_data
  replication_factor                               = each.value.replication_factor
  retain_backups_enabled                           = each.value.retain_backups_enabled
  termination_protection_enabled                   = each.value.termination_protection_enabled
  version_release_system                           = each.value.version_release_system

  dynamic "advanced_configuration" {
    for_each = each.value.advanced_configuration != null ? [each.value.advanced_configuration] : []
    content {
      change_stream_options_pre_and_post_images_expire_after_seconds = advanced_configuration.value.change_stream_options_pre_and_post_images_expire_after_seconds
      custom_openssl_cipher_config_tls12                             = advanced_configuration.value.custom_openssl_cipher_config_tls12
      default_max_time_ms                                            = advanced_configuration.value.default_max_time_ms
      default_read_concern                                           = advanced_configuration.value.default_read_concern
      default_write_concern                                          = advanced_configuration.value.default_write_concern
      fail_index_key_too_long                                        = advanced_configuration.value.fail_index_key_too_long
      javascript_enabled                                             = advanced_configuration.value.javascript_enabled
      minimum_enabled_tls_protocol                                   = advanced_configuration.value.minimum_enabled_tls_protocol
      no_table_scan                                                  = advanced_configuration.value.no_table_scan
      oplog_min_retention_hours                                      = advanced_configuration.value.oplog_min_retention_hours
      oplog_size_mb                                                  = advanced_configuration.value.oplog_size_mb
      sample_refresh_interval_bi_connector                           = advanced_configuration.value.sample_refresh_interval_bi_connector
      sample_size_bi_connector                                       = advanced_configuration.value.sample_size_bi_connector
      tls_cipher_config_mode                                         = advanced_configuration.value.tls_cipher_config_mode
      transaction_lifetime_limit_seconds                             = advanced_configuration.value.transaction_lifetime_limit_seconds
    }
  }

  dynamic "bi_connector_config" {
    for_each = each.value.bi_connector_config != null ? [each.value.bi_connector_config] : []
    content {
      enabled         = bi_connector_config.value.enabled
      read_preference = bi_connector_config.value.read_preference
    }
  }

  dynamic "labels" {
    for_each = each.value.labels != null ? each.value.labels : []
    content {
      key   = labels.value.key
      value = labels.value.value
    }
  }

  dynamic "pinned_fcv" {
    for_each = each.value.pinned_fcv != null ? [each.value.pinned_fcv] : []
    content {
      expiration_date = pinned_fcv.value.expiration_date
    }
  }

  dynamic "replication_specs" {
    for_each = each.value.replication_specs != null ? each.value.replication_specs : []
    content {
      id         = replication_specs.value.id
      num_shards = replication_specs.value.num_shards
      dynamic "regions_config" {
        for_each = replication_specs.value.regions_config != null ? replication_specs.value.regions_config : []
        content {
          analytics_nodes = regions_config.value.analytics_nodes
          electable_nodes = regions_config.value.electable_nodes
          priority        = regions_config.value.priority
          read_only_nodes = regions_config.value.read_only_nodes
          region_name     = regions_config.value.region_name
        }
      }
      zone_name = replication_specs.value.zone_name
    }
  }

  dynamic "tags" {
    for_each = each.value.tags != null ? each.value.tags : []
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

