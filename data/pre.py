"""
Pre process ORL data set.
make a dir for every face
"""
import os


def main(prefix):
    if prefix[-1] != '/':
        prefix += '/'
    for i in range(1, 41):
        os.mkdir(prefix + str(i))
    
    for i in range(1, 401):
        src = prefix + "orl%03d.bmp" % i
        dst = prefix + "%d/%d.bmp" % ((i - 1) / 10 + 1, (i - 1) % 10 + 1)
        print "mv %s to %s" % (src, dst)
        os.rename(src, dst)

if __name__ == "__main__":
    main('./ORL/')
    