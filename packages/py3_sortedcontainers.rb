require 'buildsystems/pip'

class Py3_sortedcontainers < Pip
  description 'Python Sorted Container Types: Sorted List, Sorted Dict, and Sorted Set'
  homepage 'http://www.grantjenks.com/docs/sortedcontainers/'
  version "2.4.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
