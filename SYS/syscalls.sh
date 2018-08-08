.data
    .set .L_STDOUT,        1
    .set .L_SYSCALL_EXIT,  1
    .set .L_SYSCALL_WRITE, 4
    .L_message:
        .ascii "Hello, world!\n"
        .set .L_message_len, . - .L_message

.text
    .global _start
    _start:
        # write(STDOUT, message, message_len)
        mov $.L_SYSCALL_WRITE, %eax
        mov $.L_STDOUT,        %ebx
        mov $.L_message,       %ecx
        mov $.L_message_len,   %edx
        int $0x80

        # exit(0)
        mov $.L_SYSCALL_EXIT, %eax
        mov $0,               %ebx
        int $0x80
