import os
import sys
from PIL import Image

def compress_images(scale=0.5, quality=75):
    # 1. 动态获取脚本自身所在的绝对路径，解决终端执行路径不一致的问题
    current_dir = os.path.dirname(os.path.abspath(__file__))
    output_dir = os.path.join(current_dir, "preview_images")
    
    # 支持的图片格式
    extensions = ('.jpg', '.jpeg', '.png', '.webp')
    
    # 2. 检索图片文件
    all_files = os.listdir(current_dir)
    image_files = [f for f in all_files if f.lower().endswith(extensions)]
    
    total_files = len(image_files)
    if total_files == 0:
        print(f"【提示】未在脚本所在目录中找到图片。")
        print(f"当前检索路径为: {current_dir}")
        return

    # 创建输出目录
    os.makedirs(output_dir, exist_ok=True)
    print(f"【开始处理】找到 {total_files} 张图片，准备压缩...\n")
    
    success_count = 0
    
    # 3. 遍历并打印进度
    for idx, filename in enumerate(image_files, 1):
        img_path = os.path.join(current_dir, filename)
        out_path = os.path.join(output_dir, filename)
        
        # 实时打印文字进度
        print(f"[{idx}/{total_files}] 正在处理: {filename} ... ", end="", flush=True)
        
        try:
            with Image.open(img_path) as img:
                if img.mode in ("RGBA", "P") and filename.lower().endswith(('.jpg', '.jpeg')):
                    img = img.convert("RGB")
                
                # 计算新尺寸
                new_size = (int(img.width * scale), int(img.height * scale))
                resized_img = img.resize(new_size, Image.Resampling.LANCZOS)
                
                # 保存
                if filename.lower().endswith(('.jpg', '.jpeg')):
                    resized_img.save(out_path, quality=quality, optimize=True)
                else:
                    resized_img.save(out_path, optimize=True)
            
            print("成功")
            success_count += 1
        except Exception as e:
            print(f"失败 (原因: {e})")

    print(f"\n【处理完毕】成功压缩 {success_count}/{total_files} 张图片。")
    print(f"预览图已保存在: {output_dir}")

# ==========================================
# 必须显式调用函数，脚本才会真正执行
# ==========================================
if __name__ == "__main__":
    compress_images(scale=0.5, quality=70)