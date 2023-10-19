const { default: mongoose } = require("mongoose");

const postSchema = new mongoose.Schema(
    {
        user: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User",
            required: [true, "User is required"],
        },
        title: {
            type: String,
            required:true
        },
        description: {
            type: String,
            required:true
        },
        image: {
            type: String
        },
    }, {
        timestamps:true
    }
)

const Post = mongoose.model('Post', postSchema)
module.exports = Post
