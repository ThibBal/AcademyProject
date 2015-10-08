api = 2
core = 7.x


; ----------------------------------------------------------------------------
; OPEN ACADEMY's DEPENDENCIES
;
; Open Academy - Contrib

projects[conditional_styles][type] = module
projects[conditional_styles][version] = 2.2
projects[conditional_styles][subdir] = contrib

projects[google_analytics][type] = module
projects[google_analytics][version] = 1.4
projects[google_analytics][subdir] = contrib

projects[unary][type] = theme
projects[unary][version] = 1.x-dev
projects[unary][download][type] = git
projects[unary][download][branch] = 7.x-1.x

projects[locke][type] = theme
projects[locke][version] = 1.x-dev
projects[locke][download][type] = git
projects[locke][download][branch] = 7.x-1.x

projects[radix][type] = theme
projects[radix][version] = 2.0

; ----------------------------------------------------------------------------
; OPEN ACADEMY's APPS
;
; Open Academy default apps (for use with local apps server)

projects[openacademy_core][subdir] = openacademy
projects[openacademy_core][version] = 1.0

projects[openacademy_courses][subdir] = openacademy
projects[openacademy_courses][version] = 1.0

projects[openacademy_people][subdir] = openacademy
projects[openacademy_people][version] = 1.0

projects[openacademy_events][subdir] = openacademy
projects[openacademy_events][version] = 1.0

projects[openacademy_news][subdir] = openacademy
projects[openacademy_news][version] = 1.0

projects[openacademy_publications][subdir] = openacademy
projects[openacademy_publications][version] = 1.0


; ----------------------------------------------------------------------------
; PANOPOLY
;
; The Panopoly core framework.

; Note that makefiles are parsed bottom-up, and that in Drush concurrency might
; interfere with recursion.
; Therefore PANOPOLY needs to be listed AT THE BOTTOM of this makefile,
; so we can patch or update certain projects fetched by Panopoly's makefiles.

; Someday maybe we can turn this on to just inherit Panopoly
;projects[panopoly][type] = profile
;projects[panopoly][version] = 1.x-dev
; 
; but, Drupal.org does not support recursive profiles
; and also does not support include[]
; so we need to copy the panopoly.make file here


; The Panopoly Foundation

projects[panopoly_core][version] = 1.1
projects[panopoly_core][subdir] = panopoly

projects[panopoly_images][version] = 1.1
projects[panopoly_images][subdir] = panopoly

projects[panopoly_theme][version] = 1.1
projects[panopoly_theme][subdir] = panopoly
projects[panopoly_theme][patch][2050651] = http://drupal.org/files/panopoly-theme-panels-layout-radix-2050651-5.patch

projects[panopoly_magic][version] = 1.1
projects[panopoly_magic][subdir] = panopoly

projects[panopoly_widgets][version] = 1.1
projects[panopoly_widgets][subdir] = panopoly

projects[panopoly_admin][version] = 1.1
projects[panopoly_admin][subdir] = panopoly
projects[panopoly_admin][patch][2124727] = http://drupal.org/files/panopoly_admin-2124727-save-draft-for-editors.patch

projects[panopoly_users][version] = 1.1
projects[panopoly_users][subdir] = panopoly

; The Panopoly Toolset

projects[panopoly_pages][version] = 1.1
projects[panopoly_pages][subdir] = panopoly

projects[panopoly_wysiwyg][version] = 1.1
projects[panopoly_wysiwyg][subdir] = panopoly

projects[panopoly_search][version] = 1.1
projects[panopoly_search][subdir] = panopoly
