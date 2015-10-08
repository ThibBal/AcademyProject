api = 2
core = 7.x
includes[] = drupal-org-core.make

; Download the OpenAcademy install profile and recursively build all its dependencies:
projects[openacademy][type] = profile
projects[openacademy][version] = 1.0