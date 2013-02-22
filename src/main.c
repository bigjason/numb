#include <stdio.h>
#include <stdlib.h>

int main()
{
    unsigned int position = 1;
    char *line = NULL;
    size_t size;

    while (getline(&line, &size, stdin) != -1) {
        printf("%04u: %s", position++, line);
    }

    if (line) free(line);

    return 0;
}
