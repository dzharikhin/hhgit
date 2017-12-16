import sys
import hhgit

if __name__ == "__main__":
    try:
        hhgit.to_text(sys.argv[1:-1], sys.argv[-1])
    except IOError as ioe:
        print("Failed to process those files", sys.argv[1:], ioe, file=sys.stderr)
