import os
import json


def get_files_with_tags(root_dir):
    """
    递归读取文件夹，返回一个列表，每个元素是包含 path 和 tags 的字典。
    tags 是该文件相对于 root_dir 的父目录层级列表。
    """
    result = []
    root_dir = os.path.abspath(root_dir)

    for dirpath, dirnames, filenames in os.walk(root_dir):
        for filename in filenames:
            full_path = os.path.join(dirpath, filename)
            # 计算相对路径，例如 "2026/math/B.typ"
            rel_path = os.path.relpath(full_path, root_dir)
            # 分割路径，得到各部分
            parts = rel_path.split(os.sep)
            # 文件名是最后一部分，标签是前面的目录部分
            file_name = parts[-1]
            tags = parts[:-1]  # 目录层级作为 tag，空列表表示没有 tag（根目录下）

            # 可选：如果希望根目录下的文件也有一个空标签列表，就是 tags = []
            # 这里按照例子，D.typ 在根目录下，tags 应为 []
            result.append(
                {
                    "path": rel_path.replace(os.sep, "/"),  # 统一使用 / 作为分隔符
                    "tags": tags,
                }
            )
    return result


def generate_js_code(data, var_name="fileTags"):
    """
    生成 JavaScript 代码，将数据赋值给 window 全局变量。
    """
    js_code = (
        f"window.{var_name} = " + json.dumps(data, ensure_ascii=False, indent=2) + ";"
    )
    return js_code


def main():
    # 设定文件夹路径（相对于当前脚本运行目录）
    files_dir = "content/files/files"

    if not os.path.isdir(files_dir):
        print(f"错误：文件夹 '{files_dir}' 不存在。")
        return

    # 获取文件与标签数据
    files_data = get_files_with_tags(files_dir)

    # 生成 JavaScript 代码
    js_code = generate_js_code(files_data)

    # 输出到控制台或保存为文件
    output_file = "assets/file_list.js"
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(js_code)

    print(f"已生成 JavaScript 文件：{output_file}")
    print("内容预览：")
    print(js_code)


if __name__ == "__main__":
    main()
