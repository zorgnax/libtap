add_executable (cmp_mem
	cmp_mem.c)
target_link_libraries (cmp_mem
	tap)

add_executable (cmpok
	cmpok.c)
target_link_libraries (cmpok
	tap)

add_executable (diesok
	diesok.c)
target_link_libraries (diesok
	tap)

add_executable (is
	is.c)
target_link_libraries (is
	tap)

add_executable (like
	like.c)
target_link_libraries (like
	tap)

add_executable (notediag
	notediag.c)
target_link_libraries (notediag
	tap)

add_executable (simple
	simple.c)
target_link_libraries (simple
	tap)

add_executable (skip
	skip.c)
target_link_libraries (skip
	tap)

add_executable (synopsis
	synopsis.c)
target_link_libraries (synopsis
	tap)

add_executable (todo
	todo.c)
target_link_libraries (todo
	tap)
