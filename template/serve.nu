# A nushell script that builds the website into _site directory
# and watches the Typst files for changes.

# Location to where the site will be built
const OUT_DIR: path = "_site"
# Folder where extra assets are located
const ASSETS_DIR: path = "assets"
# Location of the content directory. Where all `.typ` files are
const CONTENT_DIR: path = "content"

def compile-all [] {
    ls ...(glob $"($CONTENT_DIR)/**/*.typ") | par-each { compile-typst-to-html $in.name }
}

def main [] {
    # Start from a clean slate
    rm -rf $OUT_DIR
    mkdir $OUT_DIR

    # Initially compile all typst files
    compile-all

    # Initially place all assets in the correct location
    cp --recursive $ASSETS_DIR $"($OUT_DIR)/($ASSETS_DIR)"

    job spawn {
        # Watch Typst files for changes, and re-compile to HTML if necessary
        watch . --glob=content/**/*.typ { |op, path, new_path|
            match $op {
                Create | Write => { compile-typst-to-html $path }
                Remove => {
                    let file = $path | html-file-output-location
                    rm file
                    return
                }
                Rename => {
                    # Remove the old file
                    rm $path

                    compile-typst-to-html $new_path
                }
            }
        }
    }

    job spawn {
        # Update "_site/assets" folder if any assets changed
        watch $ASSETS_DIR { |op, path, new_path| {
            let asset_input_path = match $op {
                Remove | Create | Write => $path
                Rename => {
                    rm $path
                    $new_path
                }
            }

            # Removed an asset. Clean up.
            if $op == Remove {
                rm $path
                return
            }

            let asset_output_path = [ $OUT_DIR $asset_input_path ] | path join

            # Create parent directory, in case it doesn't exist
            mkdir ($asset_output_path | path dirname)

            cp $asset_input_path $asset_output_path
        }}
    }

    # Enjoy hot-reloading!
    #
    # live-server --open --host localhost --port 3000 _site
}

# Path to the `.html` file that will be created from the `.typ` file
def html-file-output-location [] {
   $in | parse $"content{base}.typ" | $"($OUT_DIR)($in.base.0).html"
}

# Compile a single Typst `.typ` file at the given path to a `.html` file in the
# `output` directory
def compile-typst-to-html [typst_input_path: path] {
    let typst_input_path = $typst_input_path | path relative-to $env.PWD
    let html_output_path = $typst_input_path | html-file-output-location

    # Create parent directory, in case it doesn't exist
    mkdir ($html_output_path | path dirname)

    typst compile --root . --features html --format html $typst_input_path $html_output_path
}
