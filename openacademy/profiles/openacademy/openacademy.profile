<?php

/*
 * Define minimum execution time required to operate.
 */
define('DRUPAL_MINIMUM_MAX_EXECUTION_TIME', 120);

/**
 * Implements hook_form_FORM_ID_alter()
 */
function openacademy_form_install_configure_form_alter(&$form, $form_state) {
  // Hide some messages from various modules that are just too chatty!
  drupal_get_messages('status');
  drupal_get_messages('warning');
  
  // Set a default name for the dev site and change title's label.
  $form['site_information']['site_name']['#default_value'] = t('Open Academy');

  // Set a default country so we can benefit from it on Address Fields.
  $form['server_settings']['site_default_country']['#default_value'] = 'US';

  // Use "admin" as the default username.
  $form['admin_account']['account']['name']['#default_value'] = 'admin';

  // Set the default admin password.
  $form['admin_account']['account']['pass']['#value'] = 'admin';

  // Hide Update Notifications.
  $form['update_notifications']['#access'] = FALSE;

  // Add informations about the default username and password.
  $form['admin_account']['account']['openacademy_name'] = array(
    '#type' => 'item', '#title' => st('Username'),
    '#markup' => 'admin'
  );
  $form['admin_account']['account']['openacademy_password'] = array(
    '#type' => 'item', '#title' => st('Password'),
    '#markup' => 'admin'
  );
  $form['admin_account']['account']['openacademy_informations'] = array(
    '#markup' => '<p>' . t('This information will be emailed to the site email address.') . '</p>'
  );
  $form['admin_account']['override_account_informations'] = array(
    '#type' => 'checkbox',
    '#title' => t('Change my username and password.'),
  );
  $form['admin_account']['setup_account'] = array(
    '#type' => 'container',
    '#parents' => array('admin_account'),
    '#states' => array(
      'invisible' => array(
        'input[name="override_account_informations"]' => array('checked' => FALSE),
      ),
    ),
  );

  // Make a "copy" of the original name and pass form fields.
  $form['admin_account']['setup_account']['account']['name'] = $form['admin_account']['account']['name'];
  $form['admin_account']['setup_account']['account']['pass'] = $form['admin_account']['account']['pass'];
  $form['admin_account']['setup_account']['account']['pass']['#value'] = array('pass1' => 'admin', 'pass2' => 'admin');

  // Use "admin" as the default username.
  $form['admin_account']['account']['name']['#default_value'] = 'admin';
  $form['admin_account']['account']['name']['#access'] = FALSE;

  // Set the default admin password.
  $form['admin_account']['account']['pass']['#value'] = 'admin';

  // Make the password "hidden".
  $form['admin_account']['account']['pass']['#type'] = 'hidden';
  $form['admin_account']['account']['mail']['#access'] = FALSE;

  // Add a custom validation that needs to be trigger before the original one,
  // where we can copy the site's mail as the admin account's mail.
  array_unshift($form['#validate'], 'openacademy_custom_setting');
}

/**
 * Validate callback; Populate the admin account mail, user and password with
 * custom values.
 */
function openacademy_custom_setting(&$form, &$form_state) {
  $form_state['values']['account']['mail'] = $form_state['values']['site_mail'];
  // Use our custom values only the corresponding checkbox is checked.
  if ($form_state['values']['override_account_informations'] == TRUE) {
    if ($form_state['input']['pass']['pass1'] == $form_state['input']['pass']['pass2']) {
      $form_state['values']['account']['name'] = $form_state['values']['name'];
      $form_state['values']['account']['pass'] = $form_state['input']['pass']['pass1'];
    }
    else {
      form_set_error('pass', t('The specified passwords do not match.'));
    }
  }
}

/**
 * Implements hook_form_FORM_ID_alter()
 */
function openacademy_form_apps_profile_apps_select_form_alter(&$form, $form_state) {
  // panopoly_form_apps_profile_apps_select_form_alter($form, $form_state);
  ############## INCLUDE FROM PANOPOLY #####################
  // For some things there are no need
  $form['apps_message']['#access'] = FALSE;
  $form['apps_fieldset']['apps']['#title'] = NULL;

  // Improve style of apps selection form
  if (isset($form['apps_fieldset'])) {
    $manifest = apps_manifest(apps_servers('local'));
    foreach ($manifest['apps'] as $name => $app) {
      if ($name != '#theme') {
        $form['apps_fieldset']['apps']['#options'][$name] = '<strong>' . $app['name'] . '</strong><p><div class="admin-options"><div class="form-item">' . theme('image', array('path' => $app['logo']['path'], 'height' => '32', 'width' => '32')) . '</div>' . $app['description'] . '</div></p>';
      }
    }
  }
  // ########### END PANOPOLY ################

  // Don't allow the panopoly apps to be installed here as they duplicate
  // our own apps' sunctionality.
  unset($form['apps_fieldset']['apps']['#options']['panopoly_news']);
  unset($form['apps_fieldset']['apps']['#options']['panopoly_demo']);
}

/**
 * Implements hook_form_FORM_ID_alter()
 */
function openacademy_form_panopoly_theme_selection_form_alter(&$form, &$form_state, $form_id) {
  // Remove some themes tht we don't want to offer users.
  unset($form['theme_wrapper']['theme']['#options']['radix']);
  unset($form['theme_wrapper']['theme']['#options']['radix_starter']);
  unset($form['theme_wrapper']['theme']['#options']['bartik']);
  unset($form['theme_wrapper']['theme']['#options']['responsive_bartik']);
  unset($form['theme_wrapper']['theme']['#options']['garland']);
  unset($form['theme_wrapper']['theme']['#options']['unary']);
  unset($form['theme_wrapper']['theme']['#options']['openacademy_maintenance']);

  // Move our themes to the top.
  $options = $form['theme_wrapper']['theme']['#options'];
  $form['theme_wrapper']['theme']['#options'] = array(
    'locke' => $options['locke'],
    'openacademy_default' => $options['openacademy_default'],
    'openacademy_wireframe' => $options['openacademy_wireframe'],
  ) + $options;

  // Pre set the default theme selection.
  $form['theme_wrapper']['theme']['#default_value'] = 'locke';
}

/**
 * Implements hook_appstore_stores_info()
 */
function openacademy_apps_servers_info() {
  $profile = variable_get('install_profile', 'openacademy');
  $info =  drupal_parse_info_file(drupal_get_path('profile', $profile) . '/' . $profile . '.info');
  return array(
    'local' => array(
      'title' => 'Open Academy',
      'description' => "Apps for Open Academy",
      'manifest' => '',
      'profile' => $profile,
      'profile_version' => isset($info['version']) ? $info['version'] : '7.x-1.x',
      'server_name' => (!empty($_SERVER['SERVER_NAME'])) ? $_SERVER['SERVER_NAME'] : NULL,
      'server_ip' => (!empty($_SERVER['SERVER_ADDR'])) ? $_SERVER['SERVER_ADDR'] : NULL,
    ),
  );
}
