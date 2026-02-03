# Interview Guide

基于大语言模型的简历分析和模拟面试平台。

## 技术栈

### 后端

| 技术 | 版本 | 说明 |
|------|-----|------|
| Java | 21 | 开发语言 |
| Spring Boot | 4.0 | 应用框架 |
| Spring AI | 2.0 | AI 集成 |
| PostgreSQL + pgvector | 14+ | 数据库 + 向量存储 |
| Redis | 6+ | 缓存 + 消息队列 |
| Apache Tika | 2.9.2 | 文档解析 |
| iText | 8.0.5 | PDF 导出 |
| Maven | 3.9+ | 构建工具 |

### 前端

| 技术 | 版本 | 说明 |
|------|-----|------|
| React | 18.3 | UI 框架 |
| TypeScript | 5.6 | 开发语言 |
| Vite | 5.4 | 构建工具 |
| Tailwind CSS | 4.1 | 样式框架 |

## 功能

- **简历管理**：多格式支持（PDF/DOCX/DOC/TXT）、异步分析、重复检测
- **模拟面试**：基于简历生成问题、实时问答、评估报告
- **知识库**：文档向量化、RAG 检索增强、流式响应

## 项目结构

```
interview-guide/
├── pom.xml                           # Maven 配置
├── src/
│   └── main/
│       ├── java/interview/guide/
│       │   ├── App.java              # 启动类
│       │   ├── common/               # 通用模块
│       │   ├── infrastructure/       # 基础设施
│       │   └── modules/              # 业务模块
│       │       ├── interview/        # 面试
│       │       ├── knowledgebase/    # 知识库
│       │       └── resume/           # 简历
│       └── resources/
│           ├── application.yml       # 配置文件
│           └── prompts/              # AI 提示词
├── frontend/                         # 前端应用
└── README.md
```

## 快速开始

### 环境要求

| 依赖 | 版本 | 必需 |
|-----|-----|-----|
| JDK | 21+ | 是 |
| Node.js | 18+ | 是 |
| PostgreSQL + pgvector | 14+ | 是 |
| Redis | 6+ | 是 |
| S3 兼容存储 | - | 是 |

### 1. 克隆项目

```bash
git clone https://github.com/Snailclimb/interview-guide.git
cd interview-guide
```

### 2. 配置数据库

```sql
CREATE DATABASE interview_guide;
-- pgvector 扩展会由 Spring AI 自动创建
```

### 3. 配置环境变量

```bash
export AI_BAILIAN_API_KEY=your_api_key
```

### 4. 修改应用配置

编辑 `src/main/resources/application.yml`：

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/interview_guide
    username: postgres
    password: your_password

  jpa:
    hibernate:
      ddl-auto: create  # 首次启动用 create，之后改为 update

  redis:
    redisson:
      config: |
        singleServerConfig:
          address: "redis://localhost:6379"

app:
  storage:
    endpoint: http://localhost:9000
    access-key: your_access_key
    secret-key: your_secret_key
    bucket: interview-guide
```

### 5. 启动服务

**后端：**

```bash
mvn spring-boot:run
```

后端服务：`http://localhost:8080`

**前端：**

```bash
cd frontend
pnpm install
pnpm dev
```

前端服务：`http://localhost:5173`

## 常用命令

```bash
# 编译
mvn clean compile

# 打包
mvn package -DskipTests

# 运行
mvn spring-boot:run

# 运行测试
mvn test
```

## 常见问题

### 数据库表创建失败/数据丢失

JPA `ddl-auto` 配置：

| 模式 | 行为 | 适用场景 |
|-----|-----|---------|
| create | 删除并重建表 | 首次启动 |
| update | 增量更新 | 开发环境 |
| validate | 只验证 | 生产环境 |

⚠️ 记得在表创建后改为 `update`，否则重启会丢失数据。

### 简历分析失败

检查阿里云 DashScope API KEY 是否正确配置。

### PDF 导出中文异常

检查字体文件：`src/main/resources/fonts/ZhuqueFangsong-Regular.ttf`


