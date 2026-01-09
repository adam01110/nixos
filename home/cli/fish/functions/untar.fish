if @test@ (count $argv) -eq 0
    @echo@ "Usage: extract <archive> [...]"
    return 1
end

for archive_path in $argv
    if not @test@ -f $archive_path
        @echo@ "'$archive_path' is not a valid file"
        continue
    end

    switch $archive_path
        case '*.tar.bz2' '*.tbz2'
            set list_flags -tjf
            set extract_flags -xvjf
        case '*.tar.gz' '*.tgz'
            set list_flags -tzf
            set extract_flags -xvzf
        case '*.tar.xz'
            set list_flags -tJf
            set extract_flags -xvJf
        case '*.tar.zst'
            set list_flags --zstd -tf
            set extract_flags --zstd -xvf
        case '*.tar'
            set list_flags -tf
            set extract_flags -xvf
        case '*'
            @echo@ "Unable to extract '$archive_path'"
            continue
    end

    set entries (@tar@ $list_flags $archive_path)
    if @test@ (count $entries) -eq 0
        @echo@ "'$archive_path' has no entries to extract"
        continue
    end

    set top_level_dir ""
    set has_dir 0
    set has_multiple 0

    for entry in $entries
        if @test@ -z "$entry"
            continue
        end

        if string match -q '*/*' -- $entry
            set has_dir 1
        end

        set entry_root (string split -m1 / -- $entry)[1]
        if @test@ -z "$entry_root"
            continue
        end

        if @test@ -z "$top_level_dir"
            set top_level_dir $entry_root
        else if @test@ "$entry_root" != "$top_level_dir"
            set has_multiple 1
            break
        end
    end

    if @test@ $has_multiple -eq 0 -a $has_dir -eq 1 -a -n "$top_level_dir"
        set dest_dir .
    else
        set dest_dir (string replace -r '\\.(tar\\.(bz2|gz|xz|zst)|tbz2|tgz|tar)$' '' -- (path basename -- $archive_path))
        @mkdir@ -p -- $dest_dir
    end

    if @test@ "$dest_dir" = "."
        @tar@ $extract_flags $archive_path
    else
        @tar@ $extract_flags $archive_path -C $dest_dir
    end
end
