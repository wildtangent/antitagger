antitagger
==========

Remove dead tagged links from content

```ruby
antitagger = Antitagger.new("file.txt", "list","of","tags")
puts antitagger.untag!
```