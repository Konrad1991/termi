#include <chrono>
#include <iostream>
#include <thread>

int main() {
  std::cout < "test Build" << std::endl;
  int counter = 0;
  while (counter < 100) {
    std::cout << counter << std::endl;
    counter++;
    std::this_thread::sleep_for(std::chrono::milliseconds(100));
  }
  return 0;
}
