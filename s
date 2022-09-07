#include <iostream>
#include <memory>
#include <typeinfo>

template <class T>
    class Shared_ptr {
    public:
        Shared_ptr() noexcept : m_ptr(nullptr) ,m_counter(nullptr) {}
        explicit Shared_ptr(T* ptr) noexcept : m_ptr(ptr) , m_counter(new size_t(1)) {}
        Shared_ptr(Shared_ptr&& obj) noexcept : m_ptr(obj.m_ptr), m_counter(obj.m_counter) {
            m_counter = nullptr;
            obj.m_ptr = nullptr;
        }
        Shared_ptr(const Shared_ptr& obj) noexcept : m_ptr(obj.m_ptr), m_counter(obj.m_counter) {
            ++(*m_counter);
        }
        ~Shared_ptr() {
            if (*m_counter == 1) {
                delete m_ptr;
                delete m_counter;
                m_ptr = nullptr;
                m_counter = nullptr;
            }
            else {
                --(* m_counter);
                m_ptr = nullptr;
            }
        }
    public:
        void operator = (const Shared_ptr& obj) {
            if (m_ptr == obj.m_ptr) {
                return;
            }
            if (!m_ptr) {
                m_ptr = obj.m_ptr;
                m_counter = obj.m_counter;
                ++ (* m_counter);
            }
            else {
                -- (* m_counter);
                if (*m_counter == 0) {
                    delete m_ptr;
                    delete m_counter;
                    m_ptr = nullptr;
                    m_counter = nullptr;
                }
                m_ptr = obj.m_ptr;
                m_counter = obj.m_counter;
                ++(*m_counter);
            }
        }
        void operator = (const Shared_ptr&& obj) {
            m_ptr = obj.m_ptr;
            m_counter = obj.m_counter;
            obj.m_ptr = nullptr;
            obj.m_counter = nullptr;
        }
        T& operator * () {
            return *m_ptr;
        }
        T* operator -> () {
            return m_ptr;
        }
        void reset(T* ptr = nullptr) {
            if (!ptr) {
                if (*m_counter == 1) {
                    delete m_ptr;
                    delete m_counter;
                    m_counter = nullptr;
                }
                else {
                    --(*m_counter);
                }
                m_ptr = nullptr;
            }
            else {
                ptr = m_ptr;
                --(*m_counter);
                m_counter = nullptr;
                m_ptr = nullptr;
            }
        }
        const size_t use_count() const{
            return *m_counter;
        }
    private:
        T* m_ptr;
        size_t* m_counter;
};
struct mys {
    int j = 7;
    double t = 22;
   
};

void foo() {
    std::cout << "lox";
}
int main() {
    Shared_ptr<mys> musik(new mys);
    Shared_ptr<mys> myusik(musik);
    std::cout << std::endl << "\\\\\\\\\\\\\\\\" << std::endl << myusik.use_count() << musik.use_count() << std::endl;
    musik.reset();
    std::cout << "\\\\\\\\\\\\\\\\" << std::endl << myusik.use_count() << musik.use_count() << std::endl;

    std::shared_ptr<mys> test(new mys);
    std::shared_ptr<mys> p;
    auto p2(p);
    auto p3 = std::make_shared<mys>();
    std::cout << p2.use_count();
    p2 = std::make_shared<mys>();
    std::cout << std::endl << p.use_count() << " " << p2.use_count();
}
