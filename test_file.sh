echo "========================================"
echo "Initial Cleaning in progress"

make clean
echo " Building compiler "
make all -B
COMPILER=bin/c_compiler
if [[ "$?" -ne 0 ]]; then
    echo "Build failed.";
fi
echo ""

bin/c_compiler -S test_program.c -o test_program.s

mips-linux-gnu-gcc -mfp32 -o test_program.o -c test_program.s

mips-linux-gnu-gcc -mfp32 -static -o test_program test_program.o test_program_driver.c


qemu-mips test_program

echo "========================================="
echo "Starting test"