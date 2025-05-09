import os
import sys
import time
import pyautogui
from rich import print


COCO_IMAGES = [
    "coco1.png",
    "coco2.png",
    "coco3.png",
]


def resource_path(relative_path):
    try:
        base_path = sys._MEIPASS
    except Exception:
        base_path = os.path.abspath(".")

    return os.path.join(base_path, relative_path)


def get_data():
    try:
        accounts = int(input("Enter number of accounts (1-10): "))
        if accounts < 1 or accounts > 10:
            print("Value must be between 1-10")
            sys.exit()
        return accounts
    except ValueError:
        pyautogui.alert("Invalid input. restart!")
        sys.exit()


def ensure_window():
    pyautogui.alert(
        "Make sure your browser is in the foreground and visible. Press Enter to start..."
    )


def find_and_click_any_coco():
    for image in COCO_IMAGES:
        image_path = resource_path(os.path.join("cocos", image))
        try:
            location = pyautogui.locateCenterOnScreen(image_path, confidence=0.9)
            if location:
                print(f"The COCO Found.")
                pyautogui.moveTo(location.x, location.y, duration=0.1)
                pyautogui.click()
                time.sleep(0.125)
                return True
        except pyautogui.ImageNotFoundException:
            continue
        time.sleep(0.25)
    return False


def swap_next():
    pyautogui.hotkey("ctrl", "tab")
    time.sleep(0.1)


def main():
    print("This code is the property of Larry2018. Redistribution is not allowed.")
    accounts = get_data()
    ensure_window()

    counter = 0
    counter_flag = 0

    while True:
        if counter:
            counter_flag += 1
            if counter_flag >= 999:
                counter_flag = 0
                counter = 0

        if counter >= accounts:
            counter = 0
            counter_flag = 0

            for _ in range(accounts):
                swap_next()
                time.sleep(0.25)

            time.sleep(5)
            for _ in range(accounts):
                swap_next()
                time.sleep(6)

            print("All Coco's Caught Successfully!")
            time.sleep(12000)

        if find_and_click_any_coco():
            swap_next()
            if accounts > 1:
                counter += 1
                counter_flag = 0
            else:
                print("All Coco's Caught Successfully!")
                time.sleep(12000)

        time.sleep(1)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nBot terminated by user.")
        sys.exit()
