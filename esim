#include <iostream>
#include <memory>
#include <typeinfo>
template <class T,
    class Deleter = std::default_delete<T> >
    class Unique_ptr {
    public:
        Unique_ptr() noexcept : m_ptr(nullptr) {}
        explicit Unique_ptr(T* ptr, Deleter del = Deleter{}) noexcept : m_ptr(ptr) , m_del(del) {}
        Unique_ptr(const Unique_ptr& obj) = delete;
        Unique_ptr(Unique_ptr&& obj) noexcept {
            m_ptr = obj.m_ptr;
            obj.m_ptr = nullptr;
        }
        ~Unique_ptr() {
            //delete m_ptr;
            //m_ptr = nullptr;
            // Consider deleter must have () operator
            m_del(m_ptr); 
        }
    public:
        void operator = (const Unique_ptr& obj) = delete;
        void operator = (const Unique_ptr&& obj) {
            m_ptr = obj.m_ptr;
            obj.m_ptr = nullptr;
        }
        T* release() {
            T* temp = m_ptr;
            m_ptr = nullptr;
            return temp;
        }
        void reset(T* ptr = nullptr) {
            if (!ptr) {
                m_del();
            }
            else {
                ptr = m_ptr;
                m_ptr = nullptr;
            }
        }
        void swap(const Unique_ptr* other) {
            std::swap(this, other);
        }
    private:
        T* m_ptr;
        Deleter m_del;
};
template <typename T>
struct mys {
    int j = 7;
    double t = 22;
    void operator() (T* ptr) {
        delete ptr;
        ptr = nullptr;

    }
};

void foo() {
    std::cout << "lox";
}
int main() {
    Unique_ptr<mys> xlo(new mys);
    Unique_ptr<mys, decltype(&foo)> xldo(new mys, foo);
    //std::unique_ptr<mys> sl;
}
