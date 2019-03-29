int* foo(int value)
{
    int* newMem = new int(value);
    return newMem;
}

int main()
{
    int* z = foo(10);
    delete z;
}
