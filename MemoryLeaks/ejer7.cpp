#include <iostream>
#include<vector>
using namespace std;

class Object
{
public:
    int attr1;
    ~Object()
    {
        cout << "destructor called with attr" << attr1 << endl;
    }
};

vector<Object*> vo;

void addTemporal(int val)
{
    Object* a = new Object;
    a->attr1 = val;
    vo.push_back(a);    
}

int main()
{
    addTemporal(5);
    cout << vo.at(0)->attr1 << endl;

    // delete has to be called before doing pop_back
    delete vo.at(0);
    
    // pop_back deleted pointer to Object
    cout << vo.size()<<endl;
    vo.pop_back();
    cout << vo.size()<<endl;
};
