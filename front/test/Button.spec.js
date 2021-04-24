import { mount } from '@vue/test-utils'
import Button from '~/components/atoms/Button.vue'

describe('Button', () => {
  test('コンポーネントがpropsからデータを受け取ることができる', () => {
    const props = {
      type: 'test'
    }
    const wrapper = mount(Button, {
      propsData: props
    })

    expect(wrapper.props('type')).toBe(props.type)
  })
})
